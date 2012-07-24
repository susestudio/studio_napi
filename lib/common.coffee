
asis = (parsed) -> parsed

as_array = (parsed) ->
    if parsed instanceof Array
      parsed
    else
      [parsed]

exports.asis = asis
exports.as_array = as_array

