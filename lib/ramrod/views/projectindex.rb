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
        @project.nil? ? "" : @project.name
      end

      def description
        @project.nil? ? "" : @project.description
      end

      def projecturl
        @project.nil? ? "" : @project.url
      end

      def token
        @project.nil? ? "" : @project.token
      end
    end
  end
end
