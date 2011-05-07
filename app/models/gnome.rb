class Gnome < ActiveRecord::Base
  
  validates_presence_of :name
  validates_numericality_of :age
  validates_presence_of :gender
  validates_numericality_of :cost
  
  belongs_to :user
  has_many :favoritizations
  has_many :users, :through => :favoritizations
  
  cattr_reader :per_page
  @@per_page = 10
  
  has_attached_file :photo,
                    :styles => {
                      :thumb => ["72x72#"],
                      :medium => ["300x300#"]
                    },
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => "cs446/mw_assoc/#{Rails.env}/:attachment/:id/:style.:extension",
                    :default_url => '/images/default_gnome.jpg'
  
  def self.most_recent
    first(:order => 'created_at DESC')
  end
  
end
