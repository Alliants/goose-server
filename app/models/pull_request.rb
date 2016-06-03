class PullRequest
  attr_reader :link, :title, :org, :repo, :created_at, :owner, :original_id
  attr_accessor :number_of_comments

  def initialize(args)
    @link = args.fetch(:link)
    @original_id = args.fetch(:original_id)
    @title = args.fetch(:title, "")
    @org = args.fetch(:org, "")
    @repo = args.fetch(:repo, "")
    @owner = args.fetch(:owner, "")
    @created_at = args.fetch(:created_at)
    @number_of_comments = args.fetch(:number_of_comments)
  end

  def ==(other)
    original_id == other.original_id
  end

  def to_h
    instance_variables.each_with_object({}) do |var, acc|
      acc[var.to_s.delete("@")] = instance_variable_get(var)
    end
  end
end
