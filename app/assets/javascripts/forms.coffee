readURL = (input) ->
  if input.files and input.files[0]
    reader = new FileReader

    reader.onload = (e) ->
      valueJSON = atob(e.target.result.replace('data:application/json;base64,', ''))
      $('#connector_data').text valueJSON
      return

    reader.readAsDataURL input.files[0]
  return

$('#connector_file').change ->
  readURL this
  return