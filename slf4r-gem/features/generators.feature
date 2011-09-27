Feature: Generators for slf4r

  Scenario: The slf4r rails template creates a rails application which uses slf4r-wrapper
    Given I create new rails application with template "simple.template"
    Then the output should contain "setup slf4r logger wrapper"

   Scenario: The slf4r rails template creates a rails application which uses logging gem
    Given I create new rails application with template "logging.template"
    Then the output should contain "setup slf4r logger Logging::Logger"

   Scenario: The slf4r rails template creates a rails application which uses log4j
    Given I create new rails application with template "log4j.template"
    Then the output should contain "setup slf4r logger org.slf4j.impl.Log4jLoggerAdapter"
