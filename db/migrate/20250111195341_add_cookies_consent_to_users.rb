class AddCookiesConsentToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :cookies_accepted, :boolean
  end
end
