RepositoryStorage.destroy_all
dr = DataRefresher.new(repositories: Repository.all(cache: false))
dr.refresh_all!
