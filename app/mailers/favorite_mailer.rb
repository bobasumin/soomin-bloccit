class FavoriteMailer < ActionMailer::Base
  default from: "bobasumin@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    headers["Message-ID"] = "<comments/#{@comment.id}@soomin-bloccit.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@soomin-bloccit.com>"
    headers["References"] = "<post/#{@post.id}@soomin-bloccit.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
