# frozen_string_literal: true

# A 'view model' behind the high_voltage static page @ /pages/version
module FloodRiskEngine
  class ApplicationVersionPagePresenter

    def application_name
      FloodRiskEngine.config.application_name || Rails.application.class.module_parent_name
    end

    def git_commit
      @_git_commit ||= begin
        sha =
          if Rails.env.development?
            `git rev-parse HEAD`
          else
            heroku_file = Rails.root.join ".source_version"
            capistrano_file = Rails.root.join "REVISION"

            if File.exist? capistrano_file
              File.open(capistrano_file, &:gets)
            elsif File.exist? heroku_file
              File.open(heroku_file, &:gets)
            end
          end

        sha[0...7] if sha.present?
      end
    end

    def git_commit_url
      File.join(git_repository_url, "commit", git_commit)
    end

    def git_repository_url
      FloodRiskEngine.config.git_repository_url ||
        "https://github.com/defra/#{application_name.underscore.dasherize}"
    end
  end
end
