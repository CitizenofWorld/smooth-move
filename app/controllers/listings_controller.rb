
class ListingsController < ApplicationController

  def index
    @tags = Tag.all
    
    if params[:tag_id]
      @listings = []
      @ListingTags = ListingTag.where(tag_id: params[:tag_id])
      @ListingTags.each do |listingtag|
        x = listingtag.listing
        @listings.push(x)
      end
    else
      @listings = Listing.all
    end      
  end


  def new
    @tags = Tag.all
  end

  def create
    listing = Listing.new
    listing.title = params[:title]
    listing.street = params[:street]
    listing.city = params[:city]
    listing.postcode = params[:postcode]
    listing.moving_date = params[:moving_date]
    listing.moving_time = params[:moving_time]
    listing.price = params[:price]
    listing.description = params[:description]
    listing.title = params[:title]
    listing.image = params[:image]
    listing.creator_id = session[:user_id].to_i
    if params[:helpers] == ""
      params[:helpers] = 1
    end
    listing.num_helpers_needed = params[:helpers].to_i
    listing.open = true

    listing.save

    tags = params[:tags]
    tags.each do |tag|
      listing_tag = ListingTag.new
      listing_tag.listing_id = listing.id.to_i
      listing_tag.tag_id = tag.to_i
      listing_tag.save
    end

    redirect_to '/listings'
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def show
    @listing = Listing.find(params[:id])
    @date = String(@listing.moving_time)
    @date = @date.slice(11..15)
  end

  def update
    @listing = Listing.find(params[:id])
    # redirect_to '/listings' #This can be accessed from All Listings EDIT and Dashboard EDIT. Need to find out how to go back where came from
    @listing.title = params[:title]
    @listing.street = params[:street]
    @listing.city = params[:city]
    @listing.postcode = params[:postcode]
    @listing.moving_date = params[:moving_date]
    @listing.moving_time = params[:moving_time]
    @listing.price = params[:price]
    @listing.description = params[:description]
    @listing.title = params[:title]
    @listing.image = params[:image]
    @listing.creator_id = session[:user_id].to_i
    @listing.num_helpers_needed = params[:helpers]
    @listing.save
  
    redirect_to session[:return_to]
  end

  def destroy
    listing = Listing.find(params[:id])
    listing.destroy
    redirect_to session[:return_to] #This can be accessed from All Listings EDIT and Dashboard EDIT. Need to find out how to go back where came from

  end

end
