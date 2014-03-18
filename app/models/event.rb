class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name,
      [:name, :description],
      [:name, :description, :start_at],
    ]
  end

  belongs_to :user

  validates :name, presence: true, length: { maximum: 60 }

  validates_length_of :description, minimum: 10, allow_blank: true

  validates :user, presence: true

  validates :start_at, presence: true
  validates :end_at, presence: true

  scope :for_today, ->() {
    where(["DATE(start_at) <= DATE(?) AND DATE(?) <= DATE(end_at)", Date.today, Date.today])
  }

  scope :next_week, ->() {
    start = Date.today # TODO: Complete this line
    last = start # TODO: Complete this line
    # TODO: COMPLETE THE SCOPE!!!
    where("1=1")
  }

  scope :name_like, lambda { |name|
    where(["name like ?", "%#{name}%"])
  }

  private

  def start_at_is_present
    if start_at.blank?
      errors.add(:start_at, "debes introducir la fecha de inicio")
    end
  end
end
