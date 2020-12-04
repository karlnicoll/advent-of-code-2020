require 'stringio'
require 'solution_03b'

RSpec.describe Solution03b do
  it "has a version number" do
    expect(Solution03b::VERSION).not_to be nil
  end

  it "can create a zero height hill" do
    sample_hill = ""
    expect(Solution03b::Hill.new(StringIO.new(sample_hill)).at_bottom?()).to eq(true)
  end

  it "can create a 2 height hill" do
    sample_hill = "...\n..."
    expect(Solution03b::Hill.new(StringIO.new(sample_hill)).at_bottom?()).to eq(false)
  end

  it "can descend a 2 height hill" do
    sample_hill = "...\n..."
    hill = Solution03b::Hill.new(StringIO.new(sample_hill))
    hill.descend!(1)
    expect(hill.at_bottom?()).to eq(false)
    hill.descend!(1)
    expect(hill.at_bottom?()).to eq(true)
  end

  it "can descend a 2 height hill at high speed" do
    sample_hill = "...\n..."
    hill = Solution03b::Hill.new(StringIO.new(sample_hill))
    hill.descend!(2)
    expect(hill.at_bottom?()).to eq(true)
  end

  it "can have a hill with trees" do
    sample_hill = ".#.\n..."
    hill = Solution03b::Hill.new(StringIO.new(sample_hill))
    expect(hill.get_landscape_at_position(0)).to eq(Solution03b::CLEARING)
    expect(hill.get_landscape_at_position(1)).to eq(Solution03b::TREE)
    hill.descend!(1)
    expect(hill.get_landscape_at_position(0)).to eq(Solution03b::CLEARING)
    expect(hill.get_landscape_at_position(1)).to eq(Solution03b::CLEARING)
  end

  it "can have a circular hill with trees" do
    sample_hill = ".#.\n..."
    hill = Solution03b::Hill.new(StringIO.new(sample_hill))
    expect(hill.get_landscape_at_position(0)).to eq(Solution03b::CLEARING)
    expect(hill.get_landscape_at_position(1)).to eq(Solution03b::TREE)
    expect(hill.get_landscape_at_position(2)).to eq(Solution03b::CLEARING)
    expect(hill.get_landscape_at_position(3)).to eq(Solution03b::CLEARING)
    expect(hill.get_landscape_at_position(4)).to eq(Solution03b::TREE)
    expect(hill.get_landscape_at_position(5)).to eq(Solution03b::CLEARING)
  end

  it "can solve a basic puzzle 1x3" do
    sample_hill = ".#...\n...#.\n.#..."
    expect(Solution03b::solve(StringIO.new(sample_hill), Solution03b::Toboggan.new(1, 3))).to eq(2)
  end

  it "can solve the sample puzzle 1x1" do
    sample_hill = "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#"
    expect(Solution03b::solve(StringIO.new(sample_hill), Solution03b::Toboggan.new(1, 1))).to eq(2)
  end

  it "can solve the sample puzzle 1x3" do
    sample_hill = "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#"
    expect(Solution03b::solve(StringIO.new(sample_hill), Solution03b::Toboggan.new(1, 3))).to eq(7)
  end

  it "can solve the sample puzzle 1x5" do
    sample_hill = "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#"
    expect(Solution03b::solve(StringIO.new(sample_hill), Solution03b::Toboggan.new(1, 5))).to eq(3)
  end

  it "can solve the sample puzzle 1x7" do
    sample_hill = "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#"
    expect(Solution03b::solve(StringIO.new(sample_hill), Solution03b::Toboggan.new(1, 7))).to eq(4)
  end

  it "can solve the sample puzzle 2x1" do
    sample_hill = "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#"
    expect(Solution03b::solve(StringIO.new(sample_hill), Solution03b::Toboggan.new(2, 1))).to eq(2)
  end
end
