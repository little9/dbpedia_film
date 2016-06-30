require "dbpedia_film/version"
require "sparql"
module DbpediaFilm
  class Metadata

    def self.by_title(title)

      sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
      query = sparql.query("

PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dbprop: <http://dbpedia.org/property/>
PREFIX dbowl: <http://dbpedia.org/ontology/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

SELECT ?title ?director_display ?starring_image ?director_image ?composer_display ?thumbnail ?cinematography_display ?starring_display ?studio_display ?editing_display ?dist_display  ?producer_display ?screenplay_display ?gross ?budget ?date WHERE {
?type rdf:type dbowl:Film .
?title dbprop:name ?name
FILTER regex(?name, \"^#{title}$\", 'i' ) .
?title foaf:name ?title_display .
?title dbprop:director ?director .
OPTIONAL { ?director foaf:name ?director_display . }
OPTIONAL { ?director foaf:depiction ?director_image . }
OPTIONAL { ?title dbprop:cinematography ?cinematography . }
OPTIONAL { ?cinematography foaf:name ?cinematography_display . }
OPTIONAL { ?title dbprop:editing ?editing . }
OPTIONAL { ?editing foaf:name ?editing_display . }
OPTIONAL { ?title dbprop:distributor ?distributor . }
OPTIONAL { ?title dbowl:thumbnail ?thumbnail . }
OPTIONAL { ?title dbprop:released ?date . }

OPTIONAL { ?distributor foaf:name ?dist_display . }
OPTIONAL { ?title dbprop:starring ?starring . }
OPTIONAL { ?starring foaf:name ?starring_display . }
OPTIONAL { ?starring foaf:depiction ?starring_image . }
OPTIONAL { ?title dbprop:producer ?producer . }
OPTIONAL { ?producer foaf:name ?producer_display . }
OPTIONAL { ?title dbprop:music ?composer . }
OPTIONAL { ?composer foaf:name ?composer_display . }
OPTIONAL { ?title dbprop:studio ?studio . }
OPTIONAL { ?studio foaf:name ?studio_display . }
OPTIONAL { ?title dbprop:screenplay ?screenplay . }
OPTIONAL { ?screenplay rdfs:label ?screenplay_display . }

OPTIONAL { ?title dbprop:gross ?gross . }
OPTIONAL { ?title dbowl:budget ?budget . }
} LIMIT 1


                             ")

      query.each_solution do |solution|

        director = solution.to_hash[:director_display].to_s
        director_image = solution.to_hash[:director_image].to_s
        producer = solution.to_hash[:producer_display].to_s
        starring = []
        screenplay = solution.to_hash[:screenplay_display].to_s
        composer = solution.to_hash[:composer_display].to_s
        cinematographer = solution.to_hash[:cinematography_display].to_s
        editing = solution.to_hash[:editing_display].to_s
        studio = solution.to_hash[:studio_display].to_s
        thumbnail = solution.to_hash[:thumbnail].to_s
        dist = solution.to_hash[:dist_display].to_s
        gross = solution.to_hash[:gross].to_s.to_f
        budget = solution.to_hash[:budget].to_s.to_f
        date = solution.to_hash[:date].to_s
        # release date
        # running time

        query2 = sparql.query("
          PREFIX foaf: <http://xmlns.com/foaf/0.1/>
          PREFIX dbprop: <http://dbpedia.org/property/>
          PREFIX dbowl: <http://dbpedia.org/ontology/>
          PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
          PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

          SELECT distinct ?title ?starring_display WHERE {
          ?type rdf:type dbowl:Film .
          ?title dbprop:name ?name
          FILTER regex(?name, \"^#{title}$\", 'i' ) .
                        ?title foaf:name ?title_display .
                    ?title dbprop:director ?director .
                    ?title dbowl:starring ?starring .
                    ?starring foaf:name ?starring_display .
                    } LIMIT 10")

        query2.each_solution do |solution2|
          starring.push(solution2.to_hash[:starring_display])
        end

        meta = {:director => director, :director_image => director_image, :producer => producer, :screenplay => screenplay, :starring => starring, :composer => composer, :cinematographer => cinematographer, :editing => editing, :studio => studio, :thumbnail => thumbnail, :dist => dist, :gross => gross, :budget => budget, :date => date}


        return meta


      end


    end


  end
end

