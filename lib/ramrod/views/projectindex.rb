class Ramrod
  module Views
    class Projectindex < Layout


      def boolagents
        agents.count > 0
      end

      def agents
        @agents = @agentlist.nil? ? [ ] : @agentlist
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
