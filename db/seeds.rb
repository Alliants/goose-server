require "refresh_data"

RepositoryStorage.destroy_all
dr = DataRefresher.new(Repository.all(cache: false))
dr.refresh_all!
