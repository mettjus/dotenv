Lines
  = lines:Line+ { return lines.filter(line => line).reduce((acc,next) => {
      acc[next.key] = next.value
      return acc
    }, {}) }

Line
  = _ line:StrippedLine _ "\n"* { return line }

StrippedLine "line with whitespace stripped out"
  = key:Key "=" value:Value { return {key, value} }
  / Comment { return null }

Comment
  = "#" [^\n]*

Key
  = first:[a-zA-Z_] rest:[a-zA-Z_0-9]* { return first + rest.join('') }

Value
  = "'" val:([^'\n]*) "'" _ Comment? { return val.join('') }
  / '"' val:([^"\n]*) '"' _ Comment? { return val.join('').replace('\\n','\n') } // expand new lines
  / val:([^\n#]*) _ Comment? { return val.join('').trim() }

_ "whitespace"
  = [ \t\n\r]*
