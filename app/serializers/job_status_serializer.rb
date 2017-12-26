module JobStatusSerializer
  def self.serialize(worker)
    {
      data:{
        type: 'queue-jobs',
        id: worker.provider_job_id,
        attributes: {
          resource_global_ids: worker.serialize['arguments'].first.map { |key, value| value },
          status: Sidekiq::Status::status(worker.provider_job_id)
        }
      }
    }
  end
end
