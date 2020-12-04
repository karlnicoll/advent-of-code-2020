require 'stringio'
require 'solution_03a'

RSpec.describe Solution03a do
  it "has a version number" do
    expect(Solution03a::VERSION).not_to be nil
  end

  it "can create a zero height hill" do
    sample_hill = ""
    expect(Solution03a::Hill.new(StringIO.new(sample_hill)).at_bottom?()).to eq(true)
  end

  it "can create a 2 height hill" do
    sample_hill = "...\n..."
    expect(Solution03a::Hill.new(StringIO.new(sample_hill)).at_bottom?()).to eq(false)
  end

  it "can descend a 2 height hill" do
    sample_hill = "...\n..."
    hill = Solution03a::Hill.new(StringIO.new(sample_hill))
    hill.descend!
    expect(hill.at_bottom?()).to eq(false)
    hill.descend!
    expect(hill.at_bottom?()).to eq(true)
  end

  it "can have a hill with trees" do
    sample_hill = ".#.\n..."
    hill = Solution03a::Hill.new(StringIO.new(sample_hill))
    expect(hill.get_landscape_at_position(0)).to eq(Solution03a::CLEARING)
    expect(hill.get_landscape_at_position(1)).to eq(Solution03a::TREE)
    hill.descend!
    expect(hill.get_landscape_at_position(0)).to eq(Solution03a::CLEARING)
    expect(hill.get_landscape_at_position(1)).to eq(Solution03a::CLEARING)
  end

  it "can have a circular hill with trees" do
    sample_hill = ".#.\n..."
    hill = Solution03a::Hill.new(StringIO.new(sample_hill))
    expect(hill.get_landscape_at_position(0)).to eq(Solution03a::CLEARING)
    expect(hill.get_landscape_at_position(1)).to eq(Solution03a::TREE)
    expect(hill.get_landscape_at_position(2)).to eq(Solution03a::CLEARING)
    expect(hill.get_landscape_at_position(3)).to eq(Solution03a::CLEARING)
    expect(hill.get_landscape_at_position(4)).to eq(Solution03a::TREE)
    expect(hill.get_landscape_at_position(5)).to eq(Solution03a::CLEARING)
  end

  it "can solve a basic puzzle" do
    sample_hill = ".#...\n...#.\n.#..."
    expect(Solution03a::solve(StringIO.new(sample_hill))).to eq(2)
  end

  it "can solve the sample puzzle" do
    sample_hill = "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#"
    expect(Solution03a::solve(StringIO.new(sample_hill))).to eq(7)
  end
end
