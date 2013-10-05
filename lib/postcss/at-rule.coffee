Container = require('./container')

# CSS at-rule like “@keyframes name { }”.
#
# Can contain declarations (like @font-face or @page) ot another rules.
class AtRule extends Container
  constructor: ->
    @type = 'atrule'
    super

  # Load into at-rule mixin for selected content type
  addMixin: (type) ->
    mixin = if type == 'rules' then Container.WithRules else Container.WithDecls
    return unless mixin

    for name, value of mixin.prototype
      @[name] = value
    mixin.apply(@)

  # Detect container type by child type
  push: (child) ->
    @addMixin(child.type + 's')
    @push(child)

  @raw 'params'

module.exports = AtRule
