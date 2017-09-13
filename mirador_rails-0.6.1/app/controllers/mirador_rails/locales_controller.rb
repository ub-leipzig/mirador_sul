module MiradorRails
  class LocalesController < ::ApplicationController

    def locale
      language = 'de'
      locale = MiradorRails::Locale.new(language)
      render json: locale.file_source
    rescue MiradorRails::Exceptions::LocaleNotFound
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
