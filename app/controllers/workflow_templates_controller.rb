require 'rgl/adjacency'
require 'rgl/dot'
require 'fileutils'

class WorkflowTemplatesController < ApplicationController
  
  @workflow_name
  
  def index
    @workflows = WorkflowTemplate.newest_first
  end

  def show
    _wid = params[:id]
    @workflows = WorkflowTemplate.find(_wid)
    #@dg = RGL::DirectedAdjacencyGraph["ONE","TWO" ,"TWO","THREE" ,"THREE","FOUR", "FOUR","FIVE", "SIX","FOUR", "ONE","SIX", "NINE","TEN"]
    @dag = RGL::DirectedAdjacencyGraph[];

    @workflows.transitions.each do |e|
      @dag.add_edge(e.from_state.name, e.to_state.name)
    end

    @dag.write_to_graphic_file('jpg')
    FileUtils.mv('./graph.jpg', './app/assets/images/graph.jpg');
  end

  def new
    @wf = WorkflowTemplate.new()
  end

  def create
    _name = params[:workflow_template][:name]
    _desc = params[:workflow_template][:desc]
  
    @wf = WorkflowTemplate.new({name: _name, initial_state: "root", desc: _desc})
  
    begin
      if @wf.save
        render('addedge')
      else
        puts "Workflow already exists!"
        render("new")
      end
    rescue
      puts "Caught error..."
    end
  end

  def edit
    @wid = params[:id]

    begin
      @wf = WorkflowTemplate.find(@wid)
      puts "Found workflow"
      @dg = RGL::DirectedAdjacencyGraph[];
      @wf.transitions.each do |e|
        @dg.add_edge(e.from_state.name, e.to_state.name)
      end
      @dg.write_to_graphic_file('jpg')
      FileUtils.mv('./graph.jpg', './app/assets/images/graph.jpg');
      render("removeedge")
    rescue
      puts "No workflow exists."
    end
  end

  def update
  end

  def delete
    begin
      @workflow = WorkflowTemplate.find_by_id(params[:id])
      if @workflow == nil
        puts "nil object."
      end
    rescue
      puts "caught error."
    end
  end

  def destroy
    if params[:commit] == "Ok"
      @wid = params[:id]
      puts "ID: #{params[:id]}"
      begin
        @wf = WorkflowTemplate.find(@wid)
        if(@wf != nil)
          puts "Found workflow"
          @wf.destroy
          redirect_to action: "index"
        end
      rescue
        puts "caught error."
      end
    else
      redirect_to action: "index"
    end
  end

  def addedge
    @wid = params[:wid]
    @from = params[:vfrom]
    @to = params[:vto]
    @trname = params[:vname]
    @trdesc = params[:vdesc]
    if @dg == nil
      @dg = RGL::DirectedAdjacencyGraph[];
    end
    if @from != nil && @to != nil
      begin
        @fst = State.find_by!(name: "#{@from}")
        puts "fst id: #{@fst.id}"
        @tst = State.find_by!(name: "#{@to}")
        puts "tst id: #{@tst.id}"
      rescue
        puts "caught error."
      end

      @dg.add_edge(@from, @to)

      begin
        @wf = WorkflowTemplate.find(@wid)
        puts "found workflow"
      rescue
        puts "No workflow exists."
      end

      @wf.transitions.each do |e|
        @dg.add_edge(e.from_state.name, e.to_state.name)
      end

      @dg.write_to_graphic_file('jpg')
      FileUtils.mv('./graph.jpg', './app/assets/images/graph.jpg');

      begin
        @tr = Transition.new(workflow_id: "#{@wf.id}", name: "#{@trname}", from_state_id: "#{@fst.id}", to_state_id: "#{@tst.id}", desc: "#{@trdesc}")
        @tr.save
      rescue
        puts "DB query failed."
      end
    end
  end

  def removeedge
    @wid = params[:wid]
    @from = params[:vfrom]
    @to = params[:vto]
    if @dg == nil
      @dg = RGL::DirectedAdjacencyGraph[];
    end
    if @from != nil && @to != nil
      begin
        @fst = State.find_by!(name: "#{@from}")
        puts "fst id: #{@fst.id}"
      rescue
        puts "State #{@from} not exists in DB."
      end
      begin
        @tst = State.find_by!(name: "#{@to}")
        puts "tst id: #{@tst.id}"
      rescue
        puts "State #{@to} not exists in DB."
      end

      begin
        @tr = Transition.find_by!(workflow_id: "#{@wid}", from_state_id: "#{@fst.id}", to_state_id: "#{@tst.id}")
        if(@tr == nil)
          puts "No such transition"
        else
          @tr.destroy
        end
      rescue
        puts "DB query failed."
      end
      begin
        @wf = WorkflowTemplate.find(@wid)
        puts "found workflow"
      rescue
        puts "No workflow exists."
      end

      @wf.transitions.each do |e|
        @dg.add_edge(e.from_state.name, e.to_state.name)
      end

      @dg.write_to_graphic_file('jpg')
      FileUtils.mv('./graph.jpg', './app/assets/images/graph.jpg');
    
      puts " "
      puts "workflow_id: #{@wf.id}"
      puts "name: anyname"
      puts "from_state_id: #{@fst.id}"
      puts "to_state_id: #{@tst.id}"
      puts " "
      
    end
  end
end
