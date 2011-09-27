Logging.logger.root.appenders = Logging.appenders.file(
    File.join(Rails.root, "log", "#{Rails.env}.log"),
    :layout => Logging.layouts.pattern(:pattern => '%d %l (%c) - %m\n')
)
