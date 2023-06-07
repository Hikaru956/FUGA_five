class TagsController < ApplicationController
    before_action :authenticate_user!
    before_action :session_operation


    layout  "fuga5"

    def index
        @items = (@shop.blank?)? ActsAsTaggableOn::Tag.all: \
                    ActsAsTaggableOn::Tag.where('tags.name LIKE ? AND tags.shop_id =?', "%#{@search_word}%", @shop)
        @items = @items.order(name: :asc)
        @items = @items.paginate(page: params[:page], per_page: PER_PAGE)
    end

    def show
        @item = ActsAsTaggableOn::Tag.find(params[:id])
        return redirect_to tags_path   if @item.blank?
    end

    def create
        return redirect_to root_path    unless current_user.has_permission?(User::ROLE_MANAGER)
        @item = ActsAsTaggableOn::Tag.new
        @item.name = params[:acts_as_taggable_on_tag][:name]
        @item.shop_id = params[:acts_as_taggable_on_tag][:shop_id]
        @item.name = '#'++@item.shop_id.to_s++';'++@item.name
        @item.save!
        redirect_to tag_path(id: @item.id, search_word: @search_word, search_tags: @search_tags)
    end

    def update
        return redirect_to root_path    unless current_user.has_permission?(User::ROLE_MANAGER)
        item = ActsAsTaggableOn::Tag.find_by(id: params[:id])
        item.name = params[:acts_as_taggable_on_tag][:name]
        item.name = '#'++item.shop_id.to_s++';'++item.name
        item.save!
        redirect_to tag_path(id: item.id, search_word: @search_word, search_tags: @search_tags)
    end

    def destroy
        return redirect_to root_path    unless current_user.has_permission?(User::ROLE_MANAGER)
        item = ActsAsTaggableOn::Tag.find_by(id: params[:id])
        item.destroy
        redirect_to tags_path(search_word: @search_word, search_tags: @search_tags)
    end

    private
    def peek_prams
        @search_word = params[:search_word]
        @search_tags = params[:search_tags]
    end

    def session_operation
        @shop         = current_user.shop

        @page         = params[:page]
    end
end
