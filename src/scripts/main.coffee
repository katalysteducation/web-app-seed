# Hello function -- Display the CoffeeScript greetings.
hello = (name) ->
  # Get references to DOM elements.
  helloBtn = document.getElementById('helloBtn')
  header = document.getElementById('header')

  # Add event listener waiting for 'click' event,
  # so after clicking on the button
  # it could display the new text with the given name.
  helloBtn.addEventListener 'click', (event) ->
    header.innerHTML = "Hello #{name}! <p>Greetings from CoffeeScript!</p>"

# Call hello function with 'name' argument.
hello('Katalyst Education');
