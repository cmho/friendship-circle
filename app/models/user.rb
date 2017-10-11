class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :email, :display_name, :site_name, :site_url, :site_description, :password
  validates_uniqueness_of :email

  def next
    next_user = User.where('id > ?', self.id).order(id: :desc).where(is_active: true).first
    if next_user.nil?
      next_user = User.where(is_active: true).order(id: :desc).first
    end

    next_user
  end

  def prev
    prev_user = User.where('id < ?', self.id).order(id: :desc).where(is_active: true).last
    if prev_user.nil?
      prev_user = User.where(is_active: true).order('id desc').last
    end

    prev_user
  end

  def code_installed
    # page should contain a link to the ring, the next link, and the prev link
  end

  def get_verification
    site_content = Nokogiri::HTML(HTTParty.get(self.site_url))
    verification = site_content.xpath("//meta[@name='#{Setting.ring_name.downcase.parameterize}_verification']")
    if verification.length > 0 and verification.attr('content').text.to_i == self.id
      return true
    end

    return false
  end

  def is_new?
    if self.last_reviewed.nil?
      return true
    end

    return false
  end

  def needs_review?
    if self.last_reviewed.present? and self.last_reviewed < self.updated_at
      return true
    end

    return false
  end
end
