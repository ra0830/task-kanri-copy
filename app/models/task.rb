class Task < ApplicationRecord

  validates :title, presence: true

  def self.search(search)
    if search
      Task.where(['title LIKE ?', "%#{search}%"])
    else
      Task.all.reverse_order
    end
  end

  def self.search_status(search_status)
    if search_status == 'true'
      Task.where(status: params[:task][:status])
    else
      Task.all.reverse_order
    end
  end

end
