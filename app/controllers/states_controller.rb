class StatesController < ApplicationController
  def new
    @st = State.new()
  end

  def create
    _name = params[:state][:name]
    _desc = params[:state][:desc]
  
    @st = State.new({name: _name, desc: _desc})
  
    begin
      if @st.save
        puts "State added!"
      else
        puts "State already exists!"
      end
      redirect_to action: "new"
    rescue
      puts "Caught error..."
    end
  end

  def index
  end

  def edit
  end

  def delete
  end
end
