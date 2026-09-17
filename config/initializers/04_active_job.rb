# frozen_string_literal: true

Rails.application.configure do
  # http://guides.rubyonrails.org/active_job_basics.html#backends
  config.active_job.queue_adapter =
    if Rails.env.test?
      :inline # no asynchronous background job processing
    else
      :async
    end
end
