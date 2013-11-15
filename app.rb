require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///contact.db"

get "/" do
  @contacts = Contact.order("importance DESC")
  @title = "Contact Management System"
  erb :"contacts/index"
end

get "/contacts/new" do
  @title = "New Contact"
  @contact = Contact.new
  erb :"contacts/new"
end

post "/contacts" do
  @contact = Contact.new(params[:contact])
  if @contact.save
    redirect "contacts/#{@contact.id}"
  else
    erb :"contacts/new"
  end
end

get "/contacts/:id" do
  @contact = Contact.find(params[:id])
  @title = "#{@contact.first_name} #{@contact.last_name}"
  erb :"contacts/show"
end

get "/contacts/:id/edit" do
  @contact = Contact.find(params[:id])
  @title = "Edit Contact"
  erb :"contacts/edit"
end
 
put "/contacts/:id" do
  @contact = Contact.find(params[:id])
  if @contact.update_attributes(params[:contact])
    redirect "/contacts/#{@contact.id}"
  else
    erb :"contacts/edit"
  end
end

delete "/contacts/:id" do
  @contact = Contact.find(params[:id]).destroy
  redirect "/"
end

helpers do
  def contact_show_page?
    request.path_info =~ /\/contacts\/\d+$/
  end

  def delete_contact_button(contact_id)
    erb :_delete_contact_button, locals: {contact_id: contact_id}
  end
end

class Contact < ActiveRecord::Base

  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A.+@.+\..+\Z/, message: "is not in a valid format" }
  validates :importance, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 5,
                                         message: "must be between 1 to 5" }

end