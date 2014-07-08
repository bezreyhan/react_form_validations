
{input, label, form, p} = React.DOM

R = React.DOM

Form = React.createClass
  
  getInitialState: ->
    emailValidity: ''
    passwordValidity: ''

  render: ->
    return (
      form null,
        EmailInput len: 5, requiredContent: "@", setParentState: @setValidity, validity: @state.emailValidity
        PasswordInput len: 6, setParentState: @setValidity, validity: @state.passwordValidity
    )

  setValidity: (validity) ->
    @setState validity

# --------------------------------------------------------------------

ValidationMixin =
  lengthIsValid: (e) -> 
    len = @props.len
    inputText = e.target.value
    if inputText.length >= len
      return true
    else
      return false

  contentIsValid: (e) ->

    requiredContent = @props.requiredContent
    matchFound = (requiredContent) ->
      if e.target.value.indexOf(requiredContent) > -1
        return true
      else
        return false

    if typeof requiredContent == "string"
      matchFound(requiredContent)
    else
      for content in requiredContent
        matchFound(content)

# ------------------------------------------------------------------

EmailInput = React.createClass
  
  mixins: [ValidationMixin]

  validate: (e) ->
    if @lengthIsValid(e) and @contentIsValid(e)
      @props.setParentState emailValidity: 'valid'
    else  
      @props.setParentState emailValidity: 'invalid'

  render: ->
    return (
      p null, 
        label null, 'Email'
        input type: 'text', onChange: @validate, className: @props.validity
    )

# -----------------------------------------------------------------

PasswordInput = React.createClass
  
  mixins: [ValidationMixin]

  validate: (e) ->
    if @lengthIsValid(e)  
      @props.setParentState passwordValidity: 'valid'
    else  
      @props.setParentState passwordValidity 'invalid'

  render: ->
    R.p null,
      label null, "Password"
      input type:"password", onChange: @validate, className: @props.validity

# ----------------------------------------------------------------

React.renderComponent Form(), document.getElementById('content')