class Ramrod
  module Views
    class Projectindex < Layout

      @agents = @agents || []

      def boolagents
        #@agents.len? > 0
        false
      end

      def actionurl
        @actionurl || "/projects/new"
      end

      def projectname
        @project.name
      end

      def description
        @project.description
      end

      def projecturl
        @project.url
      end

      def token
        @project.token
      end
    end
  end
end
