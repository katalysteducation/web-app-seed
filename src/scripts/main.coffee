# Call Main function adter all files are loaded - including l20n. This way we have access to document.l10n in our app.
window.onload = () ->

  # Click counter.
  counter = 0;

  # Get references to the DOM elements.
  content = document.getElementById('content')

  # Function called after templates is loaded.
  templateLoaded = ->
    # Add Content to the page from Handlebars template. TemplateManager is template helper located in _tm.coffee file.
    content.innerHTML = TemplateManager.compile "main", {
      # FIXME: What we realy wan here is to load default values from FTL file. So They cn be change by translator not a developer.
      # For now the document.l10n.formatValue method is not avilable.
      addButtonText : 'Click me!'
      clearButtonText : 'Clear counter'
    }

    # Get required DOM elements.
    prompter = document.getElementById('prompter');
    addButton = document.getElementById('addButton');
    clearButton = document.getElementById('clearButton');

    # Set default value for promter
    document.l10n.setAttributes(prompter, 'prompt', {counter : counter})

    # Add event listener waiting for 'click' event.
    addButton.addEventListener 'click', (event) ->
      document.l10n.setAttributes(prompter, 'prompt', {counter : ++counter})

    # Run clearing functuion after clicking on `clearButton`.
    clearButton.addEventListener 'click', clearCounter

    # Stet counter to 0.
    clearCounter();

  # Clear clicking counter.
  clearCounter = () ->
    counter = 0;
    document.l10n.setAttributes(prompter, 'prompt', {counter : counter})

  # load templates `main.hbs` template under `main` name.
  TemplateManager.loadTemplate "main", "templates/main.hbs", templateLoaded
