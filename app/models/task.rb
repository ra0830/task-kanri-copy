class Task < ApplicationRecord
  validates :title, presence: true

  belongs_to :user

  def self.search(search, pages)
    if search
      Task.where(['title LIKE ?', "%#{search}%"]).page(pages)
    else
      Task.all.reverse_order.page(pages)
    end
  end

  def self.search_status(search_status, task_status, pages)
    if search_status == 'true'
      Task.where(status: task_status).page(pages)
    else
      Task.all.reverse_order.page(pages)
    end
  end

end
