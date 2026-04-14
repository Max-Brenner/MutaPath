include { INPUT_PARSER      } from '../modules/input/input_parser.nf'
include { VARIANT_SELECTOR  } from '../modules/input/variant_selector.nf'

include { CONSEQUENCE_ANNOTATOR } from '../modules/annotation/consequence_annotator.nf'
include { REGULATORY_EFFECTS    } from '../modules/annotation/regulatory_effects.nf'

include { PROTEIN_EFFECTS   } from '../modules/protein/protein_effects.nf'

include { PATHWAY_MAPPER          } from '../modules/context/pathway_mapper.nf'
include { METABOLIC_IMPACT_ENGINE } from '../modules/context/metabolic_impact_engine.nf'

include { EVIDENCE_SCHEMA   } from '../modules/integration/evidence_schema.nf'

include { AI_REASONER       } from '../modules/ai/ai_reasoner.nf'

include { REPORT_GENERATOR  } from '../modules/output/report_generator.nf'

workflow MUTAPATH {

    take:
    ch_input  // tuple val(meta), path(vcf), path(reference), path(gtf)

    main:

    INPUT_PARSER(ch_input)

    VARIANT_SELECTOR(INPUT_PARSER.out.parsed)

    CONSEQUENCE_ANNOTATOR(VARIANT_SELECTOR.out.selected)
    REGULATORY_EFFECTS(VARIANT_SELECTOR.out.selected)  // optional — skipped if params.regulatory_bed is null

    PROTEIN_EFFECTS(CONSEQUENCE_ANNOTATOR.out.annotated)

    PATHWAY_MAPPER(CONSEQUENCE_ANNOTATOR.out.annotated)
    METABOLIC_IMPACT_ENGINE(PATHWAY_MAPPER.out.pathways)

    EVIDENCE_SCHEMA(
        PROTEIN_EFFECTS.out.effects,
        METABOLIC_IMPACT_ENGINE.out.metabolic
    )

    AI_REASONER(EVIDENCE_SCHEMA.out.schema)

    REPORT_GENERATOR(AI_REASONER.out.reasoning)

    emit:
    report = REPORT_GENERATOR.out.report

}
