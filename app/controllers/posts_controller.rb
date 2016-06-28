class PostsController < ApplicationController

	before_filter :authenticate_user!, :except => :show

	def show
		@board = Board.find(params[:board_id])
		@post = @board.posts.find(params[:id])
	end

	def new
		@board = Board.find(params[:board_id])
		@post = @board.posts.build
	end

	def create
		@board = Board.find(params[:board_id])
		@post = @board.posts.build(params[:post]) #這裏要記得加參數:post，才能傳回輸入的值
		@post.user_id = current_user.id #新增資料附上user_id

		if @post.save
			respond_to do |format|
				format.html { redirect_to board_path(@board), :notice => 'Post has been created~~~'}
			end
		else
			respond_to do |format|
				format.html { render action: 'new' }
			end
		end

	end

	def edit
		@board = Board.find(params[:board_id])
		@post = current_user.posts.find(params[:id])
	end

	def update
		@board = Board.find(params[:board_id])
		@post = current_user.posts.find(params[:id])

		if @post.update_attributes(params[:post])
			respond_to do |format|
				format.html { redirect_to board_path(@board), :notice => 'Post has been updated'}
			end
		else
			respond_to do |format|
				format.html { render action: 'edit' }
			end
		end

	end

	def destroy
		@board = Board.find(params[:board_id])
		@post = current_user.posts.find(params[:id])
		@post.destroy

		respond_to do |format|
			format.html { redirect_to board_path(@board), :notice => "Post has been destroyed!!"}
		end

	end

end
