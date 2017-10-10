class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :email, :display_name, :site_name, :site_url, :site_description, :password
  validates_uniqueness_of :email

  def next
    next_user = User.where('id > ?', self.id).order(id: :desc).where(is_active: true).first
    if next_user.empty?
      next_user = User.where(is_active: true).order(id: :desc).first
    end

    next_user
  end

  def prev
    prev_user = User.where('id < ?', self.id).order(id: :desc).where(is_active: true).last
    if prev_user.empty?
      prev_user = User.where(is_active: true).order('id desc').last
    end

    prev_user
  end
end
