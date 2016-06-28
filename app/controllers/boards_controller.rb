require 'csv'
class BoardsController < ApplicationController
	before_filter :set_locale

	def index
		@boards = Board.all    
		respond_to do |format|
			format.html
			format.json { render :json => @boards.map(&:attributes) }
			format.xml { render :xml => @boards.to_xml }
      format.csv do
        csv_string = CSV.generate do |csv|
            csv << ["Name", "Created At", "Posts"]
            @boards.each do |board|
                csv << [board.name, board.created_at, board.posts.size]
            end
        end
        render :text => csv_string
      end
    end

	end

	def show
		@board = Board.find(params[:id])
		@posts = @board.posts.all
	end

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

end
