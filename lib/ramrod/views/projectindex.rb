class Ramrod
  module Views
    class Projectindex < Layout

      @agents = @agents || []

      def boolagents
        @agents.len? > 0
      end

      def actionurl
        @actionurl || "/projects/create"
      end

    end
  end
end
