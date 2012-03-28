#!/usr/bin/env ruby

# 
# == Synopsis
#
# Organization class containing all operations around curriculum objects
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

class Myplanmain
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
    
  # Load curriculum homepage
  def homepage
            
  end
  
  
  # Create a proposal
  # TODO: Org ID is hardcoded to Fisheries Department in requests, need to use dyn_variable
  #
  # Option: DEFAULT_VALUE
  # * 'mode': 'blank'
  def search_course(title, oversight_department, admin_org, opts={})
    
    first_var = "test"
    second_var = "test2"
    
    defaults = {
      :search_person => '%%_username%%', #user is the dynvar from users.csv
      :mode => 'blank',
      :nav_homepage => true,
      :submit => true,
   }
    
    # Version for the doc at each step. We'll increment on each usage
    # So first usage should eval to 0
    version_indicator = -1
    
    opts = defaults.merge(opts)
    
    title << '_%%ts_user_server:get_unique_id%%' if(opts[:append_unique_id])
    
    if(opts[:mode] != "blank")
      # select template or copy course...
    end
    
    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])
    
    puts "creating proposal as: #{opts[:propose_person]}"
    
    # Create a course
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:propose_person]}|useCurriculumReview|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )
    

    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )
    

    @request.add_thinktime(22)

    # Save & Continue
    contents1 = "5|0|41|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|proposal|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|type|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|kuali.proposal.type.course.create|workflowNode|PreRoute|name|#{opts[:proposal_title]}|_runtimeData|dirty|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|rationale|#{opts[:course_rationale]}|courseTitle|#{opts[:course_title]}|transcriptTitle|subjectArea|courseNumberSuffix|instructors|#{opts[:course_short_title]}|#{opts[:subject_area]}|#{opts[:course_suffix]}|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|personId|#{opts[:instructor]}|id-translation|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|descr|plain|#{opts[:course_description]}"
    contents2 = "|1|2|3|4|1|5|5|6|7|0|8|8|9|10|5|6|7|0|5|8|11|12|13|8|14|12|15|8|16|12|17|8|18|10|5|6|7|0|1|8|19|10|5|6|7|0|2|-11|20|21|1|8|22|20|-22|-15|-17|-5|-13|-23|12|23|-1|-3|8|24|12|25|-13|10|5|6|7|0|1|-17|10|5|6|7|0|5|-26|20|-22|8|26|20|-22|8|27|20|-22|8|28|20|-22|8|29|20|-22|-29|-17|-1|-13|-35|12|30|-37|12|31|-39|12|32|-41|10|5|6|7|0|1|33|34|0|10|5|6|7|0|2|8|35|12|36|8|18|10|5|6|7|0|1|8|35|10|5|6|7|0|1|8|37|12|38|-58|-60|-52|-56|-47|-49|-1|8|29|8|39|10|5|6|7|0|2|8|40|12|41|-13|10|5|6|7|0|1|-17|10|5|6|7|0|1|-71|20|-22|-74|-17|-69|-13|-1|-67|0|0|"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}"
      },
      {
        :dyn_variables => [
          {"name" => opts[:proposal_dyn_var_name], "regexp" => opts[:proposal_dyn_var_regexp]},
          {"name" => opts[:clu_ref_dyn_var_name], "regexp" => opts[:clu_ref_dyn_var_regexp]},
          {"name" => opts[:proposal_doc_id_var_name], "regexp" => opts[:proposal_doc_id_var_regexp]},
          {"name" => opts[:version_ind_id_name], "regexp" => opts[:version_ind_id_regexp]}
        ]
      }
    )

    #@request.add("DEBUG/proposal_dyn_var_name/%%_#{opts[:proposal_dyn_var_name]}%%", {}, {'subst' => 'true'})
    #@request.add("DEBUG/clu_ref_dyn_var_name/%%_#{opts[:clu_ref_dyn_var_name]}%%", {}, {'subst' => 'true'})
    #@request.add("DEBUG/proposal_doc_id_var_name/%%_#{opts[:proposal_doc_id_var_name]}%%", {}, {'subst' => 'true'})
    #@request.add("DEBUG/version_ind_id_name/%%_#{opts[:version_ind_id_name]}%%", {}, {'subst' => 'true'})
    

    
    #
    # Learning Objectives
    #

    @request.add_thinktime(5)

    
  end
  
  
  
  def scratch
    
    
  end
  

end