class CommentsController < ApplicationController

  load_and_authorize_resource

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.xml
  def create

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment.commentable, :notice => 'Comment was successfully created.') }
      else
        format.html { redirect_to(@comment.commentable, :notice => 'Couldnt create comment.') }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.json { render :json => jeditable_result(@comment, true) }
        format.html { redirect_to(@comment.commentable, :notice => 'Comment was successfully updated.') }
      else
        format.json { render :json => jeditable_result(@comment, false) }
        format.html { redirect_to(@comment.commentable, :notice => 'Couldnt update comment.') }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    commentable = @comment.commentable

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(commentable) }
    end
  end
end
