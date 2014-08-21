# the following line is required for PaperTrail >= 3.0.3 with Rails
PaperTrail::Rails::Engine.eager_load!
# will make it so that a maximum of 4 versions will be stored for each object
# (the 3 most recent ones plus a `create` event)
PaperTrail.config.version_limit = 3