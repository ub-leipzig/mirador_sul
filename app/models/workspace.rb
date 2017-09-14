class Workspace < ApplicationRecord
  validates :name, presence: true
  default_scope { order(name: :asc) }
  belongs_to :collection, counter_cache: true
  belongs_to :user

  serialize :data, JSON

  def data
    return {}.to_json if super.blank?
    super
  end
end
