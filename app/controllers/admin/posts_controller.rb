class Admin::PostsController < ApplicationController
	layout 'admin'
	before_filter :require_is_admin
	before_filter :find_board
	before_filter :authenticate_user!, :except => [:index]

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update_attributes(params[:post])
			respond_to do |format|
				format.html { redirect_to admin_board_post_path(@board, @post), :notice => 'Post has been updated'}
			end
		else
			respond_to do |format|
				format.html { render action: 'edit' }
			end
		end

	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		respond_to do |format|
			format.html { redirect_to @board, :notice => "Post has been destroyed!!"}
		end

	end

	protected

	def find_board
		@board = Board.find(params[:board_id])
	end


end
