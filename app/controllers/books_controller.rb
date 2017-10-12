require_relative '../../config/environment'
require 'rack-flash'
class BooksController < ApplicationController

  use Rack::Flash

  get '/books' do
    if Helpers.is_logged_in?(session)
      @books = Book.all
      erb :'books/index'
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

  get '/books/new' do
    if Helpers.is_logged_in?(session)
      @books = Book.all
      @authors = Author.all
      @publishers = Publisher.all
      @genres = Genre.all

      erb :'books/new'
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

  post '/books' do
    if Helpers.is_logged_in?(session)
      #INPUT VALIDATION!!!
      flash[:message] = []
      has_error = false
      if !params[:book][:name] || params[:book][:name].empty?
        flash[:message] << "*Please specify a book name*"
        has_error = true
      end


      if (!params[:book][:author] || params[:book][:author].empty?) && (!params[:author][:name] || params[:author][:name].empty?)
        flash[:message] << "*Please specify an author or create a new author*"
        has_error = true
      end

      if !params[:book][:author].empty? && !params[:author][:name].empty?
        flash[:message] <<  "*Only one author per book.  Please either the new author field or the author dropdown.*"
        has_error = true
      end

      if (!params[:book][:publisher] || params[:book][:publisher].empty?) && (!params[:publisher][:name] || params[:publisher][:name].empty?)
        flash[:message] << "*Please specify an author or create a new publisher*"
        has_error = true
      end

      if !params[:book][:publisher].empty? && !params[:publisher][:name].empty?
        flash[:message] <<  "*Only one publisher per book.  Please either the new publisher field or the publisher dropdown*"
        has_error = true
      end

      if !params[:book][:year_published] || params[:book][:year_published].empty?
        flash[:message] <<  "*Please enter a publication year*"
        has_error = true
      end

      if (!params[:book][:genre_ids] || params[:book][:genre_ids].empty?) && (!params[:genre][:name] || params[:genre][:name].empty?)
        flash[:message] <<  "*Please select or create at least one genre*"
        has_error = true
      end

      redirect to '/books/new' if has_error == true

      #ACTUAL OBJECT CREATION

      @books = Book.all
      if !Book.all.detect{ |b| b.name == params[:book][:name] }
        @book = Book.create(name: params[:book][:name], has_been_read: params[:book][:has_been_read])

      else
        @book = Book.find_by(:name => params[:book][:name])
        #set alternate flash message here LATER
        redirect to "/books/#{@book.slug}"
      end

      #associating book with author

      if !params[:author][:name].empty?
        @book.author = Author.find_or_create_by(:name => params[:author][:name])
      else
        @book.author = Author.find_by(:name => params[:book][:author])
      end
      @book.save
      #associating book with existing publisher
      if !params[:publisher][:name].empty?
        @book.publisher = Publisher.find_or_create_by(:name => params[:publisher][:name])
      else
        @book.publisher = Publisher.find_by(:name => params[:book][:publisher])
      end

      #associating a book with existing genres
      if params[:book][:genre_ids]
        params[:book][:genre_ids].each do |g|
          @book.genres << Genre.find(g)
        end
      end

      #associating book with a new genre
      if !params[:genre][:name].empty?
        if !Genre.all.detect {|g| g.name == params[:genre][:name]}
          @book.genres << Genre.create(:name => params[:genre][:name])

        else
          @book.genres << Genre.find_by(name: params[:genre][:name])
        end
      end

      @book.user = Helpers.current_user(session)

      #editing book's publication year
      #
      @book.year_published = params[:book][:year_published]
      # saving book
      @book.save

      redirect to "/books/#{@book.slug}"
    end
  end

  get '/books/:slug' do
    if Helpers.is_logged_in?(session)
      @books = Book.all
      @book = Book.find_by_slug(params[:slug])
      erb :'books/show'
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

  get '/books/:slug/edit' do
    if Helpers.is_logged_in?(session)
      @books = Book.all
      @authors = Author.all
      @publishers = Publisher.all
      @genres = Genre.all
      @book = Book.find_by_slug(params[:slug])
      binding.pry
      if Helpers.current_user(session) == @book.user
        erb :'books/edit'
      else
        erb :'sessions/wrong_user_error'
      end
    else
      erb :'sessions/authentication_error', :layout => false
    end
  end

  patch '/books/:slug' do
    if Helpers.is_logged_in?(session)

      #INPUT VALIDATION!!!
      flash[:message] = []
      has_error = false
      if !params[:book][:name] || params[:book][:name].empty?
        flash[:message] << "*Please specify a book name*"
        has_error = true
      end

      if (!params[:book][:author] || params[:book][:author].empty?) && (!params[:author][:name] || params[:author][:name].empty?)
        flash[:message] << "*Please specify an author or create a new author*"
        has_error = true
      end

      if !params[:book][:author].empty? && !params[:author][:name].empty?
        flash[:message] <<  "*Only one author per book.  Please either the new author field or the author dropdown.*"
        has_error = true
      end

      if (!params[:book][:publisher] || params[:book][:publisher].empty?) && (!params[:publisher][:name] || params[:publisher][:name].empty?)
        flash[:message] << "*Please specify an author or create a new publisher*"
        has_error = true
      end

      if !params[:book][:publisher].empty? && !params[:publisher][:name].empty?
        flash[:message] <<  "*Only one publisher per book.  Please either the new publisher field or the publisher dropdown*"
        has_error = true
      end

      if !params[:book][:year_published] || params[:book][:year_published].empty?
        flash[:message] <<  "*Please enter a publication year*"
        has_error = true
      end

      if (!params[:book][:genre_ids] || params[:book][:genre_ids].empty?) && (!params[:genre][:name] || params[:genre][:name].empty?)
        flash[:message] <<  "*Please select or create at least one genre*"
        has_error = true
      end

      redirect to "/books/#{params[:slug]}/edit" if has_error == true



      @book = Book.find_by_slug(params[:slug])
      if Helpers.current_user(session) == @book.user
        @books = Book.all
        @book.name = params[:book][:name]


        #associating book with author

        if !params[:author][:name].empty?
          @book.author = Author.find_or_create_by(:name => params[:author][:name])
        else
          @book.author = Author.find_by(:name => params[:book][:author])
        end

        #associating book with existing publisher
        if !params[:publisher][:name].empty?
          @book.publisher = Publisher.find_or_create_by(:name => params[:publisher][:name])
        else
          @book.publisher = Publisher.find_by(:name => params[:book][:publisher])
        end

        #associating a book with existing genres
        #edited from original new.erb so that duplicates are not added
        @book.genres = params[:book][:genre_ids].collect { |g| Genre.find(g)}

        #associating book with a new genre

        if !params[:genre][:name].empty?

          if !Genre.all.detect {|g| g.name == params[:genre][:name]}
            @book.genres << Genre.create(:name => params[:genre][:name])
          elsif !@book.genres.detect{|g| g.name == params[:genre][:name]}
            #the above was edited so that duplicates would not be added to the genre through the new genre field

            @book.genres << Genre.find_by(name: params[:genre][:name])
          end
          #if the genre is already detected in the book's genres array, this whole statement just does nothing.
        end

        # editing book's publication year
        @book.year_published = params[:book][:year_published]
        @book.has_been_read = params[:book][:has_been_read]
        #saving book
        @book.save

        flash[:message] = "Book Successfully Deleted"

        redirect to "/books/#{params[:slug]}"
      else
        erb :'sessions/wrong_user_error'
      end
    else
      erb :'sessions/authentication_error'
    end
  end

  delete '/books/:slug/delete' do
    if Helpers.is_logged_in?(session)
      @book = Book.find_by_slug(params[:slug])
      if Helpers.current_user(session) == @book.user
        @book.delete
        @book.author.delete if @book.author.books.count == 0
        @book.publisher.delete if @book.publisher.books.count == 0
        @book.genres.each do |g|
          g.delete if g.books.count == 0
        end
        flash[:message] = "Book Successfully Deleted"
        redirect to "/books"
      else
        erb :'sessions/wrong_user_error'
      end
    else
      erb :'sessions/authentication_error'
    end
  end

  #later add functionality that says if the author has no books, the author instance is deleted

end
