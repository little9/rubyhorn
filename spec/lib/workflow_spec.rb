require 'spec_helper'

describe Rubyhorn::MatterhornClient do
  before(:all) do
    Rubyhorn.init
    @client = Rubyhorn.client
    video = File.new "spec/fixtures/dance_practice.ogx"
    workflow = @client.addMediaPackage(video, {"title" => "hydrant:13", "flavor" => "presenter/source", "workflow" => "hydrant"})
    @id = workflow.id[0]
  end

  after(:all) do
    #TODO cleanup by deleting mediapackage and workflow instance?
  end

  describe "instance_xml" do
    it "should return a Workflow object for the given id" do
      workflow = @client.instance_xml @id
      workflow.should be_an_instance_of Rubyhorn::Workflow
      workflow = workflow.workflow
      workflow.template[0].should eql "hydrant"
      workflow.mediapackage.title[0].should eql "hydrant:13"
      workflow.mediapackage.media.track.type[0].should eql "presenter/source"
    end
  end

#  describe "stop" do
#    it "should return a Workflow object of the stopped workflow instance for the given id" do
#      workflow = @client.stop @id
#      puts workflow.to_xml
##      workflow = workflow.workflow
#      workflow.id.should eql @id
#      puts workflow.state
#      workflow.state.should eql "STOPPED"
#      workflow.mediapackage.title[0].should eql "hydrant:13"
#    end
#  end
end
