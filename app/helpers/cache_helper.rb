module CacheHelper
  def cache_if_not_signed_in(*args)
    if !user_signed_in?
      cache args do
        yield
      end
    else
      yield
    end
  end
end