(variable_declaration 
  type: (predefined_type) @type (#eq? @type "string")
  (variable_declarator 
    name: (identifier) @identifier (#eq? @identifier "query") 
    (interpolated_string_expression 
      (string_content) @injection.content (#set! injection.language "sql") 
      ) 
    )
)
