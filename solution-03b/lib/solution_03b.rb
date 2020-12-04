require "solution_03b/version"

module Solution03b
  class Error < StandardError; end

  TREE = '#'
  CLEARING = '.'

  class Hill
    TREE_CHAR = '#'
    CLEARING_CHAR = '.'

    def initialize(grid_file)
      @grid_file = grid_file
      self.descend!(1)
    end

    def descend!(speed)
      begin
        while speed > 0
          @current_altitude_landscape = @grid_file.readline().strip()
          speed -= 1
        end
      rescue
        @current_altitude_landscape = nil
      end
    end

    def get_landscape_at_position(x)
      return @current_altitude_landscape[x % @current_altitude_landscape.length]
    end

    def at_bottom?()
      return @current_altitude_landscape.nil?
    end
  end

  class Toboggan
    attr_reader :speed
    attr_reader :x_pos

    def initialize(speed, heading)
      @speed = speed
      @heading = heading
      @x_pos = 0
    end

    def move!
      @x_pos += @heading
    end
  end

  def self.solve(input_file, toboggan)
    hill = Hill.new(input_file)
    trees_hit = 0

    while !hill.at_bottom?
      if TREE == hill.get_landscape_at_position(toboggan.x_pos)
        trees_hit += 1
      end
      # Crappy abstraction is crappy.
      hill.descend!(toboggan.speed)
      toboggan.move!
    end

    return trees_hit
  end
end
