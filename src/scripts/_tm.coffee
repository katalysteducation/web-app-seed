class TemplateManager

  constructor: () ->
    @templates = new Array
    @contexts = new Array

  addTemplate: (name, template) ->
    @templates[name] = template

  loadTemplate: (name, path, callback) ->

    template = @templates[name]
    throw new Error("Template key #{name} already exists") if template?

    if !template?
      $.ajax
        url: path
        success: (templateHTML) =>
          @addTemplate name, Handlebars.compile(templateHTML)
          callback() if callback?
    else
      callback() if callback?

  compile: (name, context = {}) ->
    # load the last context if the passed one is blank
    context = @contexts[name] if !context?
    template = @templates[name]

    @contexts[name] = context
    template context

# Export global TemplateManager object.
TemplateManager = new TemplateManager()
