return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  build = "bundled_build.lua",
  config = function()
    local mcphub = require("mcphub")
    mcphub.setup({ use_bundled_binary = true })

    mcphub.add_server("notes", {
      name = "notes",
      capabilities = {
        tools = {
          {
            name = "search",
            description = "Search notes by query",
            inputSchema = {
              type = "object",
              properties = {
                query = {
                  type = "string",
                  description = "Search query for notes",
                },
              },
            },
            handler = function(req, res)
              local query = req.params.query
              if not query or query == "" then return res:error("Query cannot be empty") end

              -- Run the `zk list --match` command
              local command = "zk list --match " .. string.format("%q", query)
              local handle = io.popen(command)
              local result = handle:read("*a")
              handle:close()

              -- Check if results are empty
              if result == "" then return res:text("No matches found for query: " .. query):send() end

              -- Return the search results
              return res:text("Search results for '" .. query .. "':\n" .. result):send()
            end,
          },
          {
            name = "create",
            description = "create a note before finalizing it",
            inputSchema = {
              type = "object",
              properties = {
                title = {
                  type = "string",
                  description = "The title that describes the content well",
                  required = true,
                },
                content = {
                  type = "string",
                  description = "The content of the note written in markdown",
                  required = true,
                },
                tags = {
                  type = "string[]",
                  description = "The tags that summarize the content well",
                  required = true,
                },
              },
            },
            handler = function(req, res)
              local title = req.params.title
              local tags = req.params.tags
              local content = req.params.content
              if not content or content == "" then return res:error("Error: Content cannot be empty") end

              -- Store the note details temporarily
              temp_note_storage = {
                title = title,
                tags = tags,
                content = content,
              }

              -- Display the preview to the user
              return res
                :text("Preview of the note:")
                :text("Title: " .. (title or "Untitled"))
                :text("Tags: " .. table.concat(tags or {}, ", "))
                :text("Content:\n" .. content)
                :text("If you approve, run the 'finalize' tool to create the note.")
                :send()
            end,
          },
          {
            name = "finalize",
            description = "Finalize and create the note after previewing",
            handler = function(req, res)
              if not temp_note_storage.content then
                return res:error("Error: No note content found. Please preview the note first.")
              end

              local title = temp_note_storage.title
              local tags = temp_note_storage.tags
              local content = temp_note_storage.content

              -- Create the note
              local temp_file = "/tmp/zk_temp_content.md" -- Temporary file to store content
              local file = io.open(temp_file, "w")
              file:write(content) -- Write the content with newlines preserved
              file:close()

              local command = "zk new --interactive --extra tags="
                .. string.format("%q", table.concat(tags, "\\,"))
                .. " --title "
                .. string.format("%q", title)
                .. " -p < "
                .. temp_file

              local handle = io.popen(command)
              local result = handle:read("*a") -- Path of the created note
              handle:close()
              os.remove(temp_file)

              -- Read the content of the created note
              local note_file = result:match("^%s*(.-)%s*$") -- Trim whitespace
              local note_content = ""
              if note_file and note_file ~= "" then
                local note_handle = io.open(note_file, "r")
                if note_handle then
                  note_content = note_handle:read("*a")
                  note_handle:close()
                else
                  return res:error("Error: Unable to read the created note at path: " .. note_file)
                end
              else
                return res:error("Error: Failed to retrieve the path of the created note")
              end

              -- Clear the temporary storage
              temp_note_storage = {}

              return res:text("Content of the note created at path " .. note_file .. ":\n" .. note_content):send()
            end,
          },
        },
        prompts = {
          {
            name = "note",
            description = "Create a note",
            handler = function(req, res)
              return res
                :text(
                  "@mcp I would like to create a note using the notes server with the create tool. The information for this note should come from our chat above. The first part of the content should quickly describe the problem/question I had. The second part should be a summary your answers in a concise way such that i can use them again later. The format of the content should be in markdown."
                )
                :send()
            end,
          },
          {
            name = "note-finalize",
            description = "Create a note",
            handler = function(req, res)
              return res
                :text("@mcp I would like to finalize the note using the notes server with the finalize tool.")
                :send()
            end,
          },
        },
      },
    })
  end,
}
