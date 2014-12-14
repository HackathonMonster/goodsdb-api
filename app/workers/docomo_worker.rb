class DocomoWorker
  include Sidekiq::Worker

  def perform(item_id)
    item = Item.find(item_id)
    item.save_info
  end
end
