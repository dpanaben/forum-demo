class Admin::BoardsController < ApplicationController
	layout 'admin'

	before_filter :require_is_admin

	def index
		@boards = Board.all
		
		@board_all = Board.all.collect(&:name)
		@post_title_all = Post.all.collect(&:title)
		@post_content_all = Post.all.collect(&:content)
	end

	def new
		@board = Board.new
		respond_to do |format|
			format.html
		end

	end

	def create
		@board = Board.new(params[:board])
		if @board.save
			respond_to do |format|
				format.html { redirect_to @board, :notice => 'Board has been created~~!!' }
			end
		else
			respond_to do |format|
				format.html { render action: 'new' }
			end
		end

	end

	def edit
		@board = Board.find(params[:id])
		respond_to do |format|
			format.html
		end

	end

	def update
		@board = Board.find(params[:id])
		if @board.update_attributes(params[:board])
			respond_to do |format|
				format.html { redirect_to @board, :notice => 'Board has been updated~~!!'}
			end
		else
			respond_to do |format|
				format.html { render action: 'edit'}
			end
		end

	end

	def destroy
		@board = Board.find(params[:id])
		@board.destroy

		respond_to do |format|
			format.html { redirect_to admin_boards_path, :notice => 'Board has beed destroyed~~~!!!!'}
		end

	end

end
