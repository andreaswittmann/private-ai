# Private AI - LibreChat AWS Live-Scripting Repository

## Project Overview
Transform the existing LibreChat AWS implementation into a focused GitHub repository demonstrating Andreas Wittmann's live-scripting methodology through a complete, executable deployment workflow.

## Repository Structure
```
private-ai/
├── README.md                           # Project overview and usage
├── LICENSE                             # MIT license
├── librechat-aws-deployment.org        # Complete live-scripting workflow
├── terraform/                          # Infrastructure as code
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── configs/                            # Configuration templates
│   ├── docker-compose.yml
│   ├── nginx.conf
│   └── .env.template
└── diagrams/                           # Architecture diagrams
    ├── architecture.drawio
    └── docker-compose.drawio
```

## Live-Scripting Workflow

### Central Document: `librechat-aws-deployment.org`
Complete deployment workflow using Andreas Wittmann's live-scripting methodology:

```org
#+TITLE: LibreChat AWS Deployment - Live-Scripting Workflow
#+AUTHOR: Live-Scripting Methodology Demonstration

* Introduction & Project Overview
** Personal motivation for privacy-focused AI
** Architecture overview
** Expected outcomes

* Part 1: Foundation & Prerequisites  
** AWS account setup and validation
** Development environment preparation
** Checkpoint: Environment ready

* Part 2: Infrastructure as Code
** Terraform configuration and deployment
** EC2 instance provisioning with security
** Checkpoint: Infrastructure operational

* Part 3: Core LibreChat Deployment
** Docker environment setup
** LibreChat configuration and deployment
** Checkpoint: Basic system working

* Part 4: Security & Production
** SSL certificate setup and NGINX configuration
** Security hardening
** Checkpoint: Production-ready

* Part 5: Advanced Features
** RAG functionality with Ollama
** Multi-model AWS Bedrock integration
** Checkpoint: Complete system

* Troubleshooting & Maintenance
** Common issues and solutions
** Cost optimization strategies

* Reflection & Lessons Learned
** Personal insights and discoveries
** Alternative approaches considered
```

### Live-Scripting Execution Method
- **Editor**: Emacs with org-mode and vterm side-by-side
- **Execution**: Use `aw_send-line-to-vterm` (F4 key) to send commands to terminal
- **Documentation**: Code blocks provide syntax highlighting, execution happens in vterm
- **Session**: Persistent vterm environment maintains state throughout workflow

### Code Block Format
```org
#+BEGIN_SRC bash
# Validate prerequisites
whoami; hostname; pwd
aws sts get-caller-identity
terraform --version
#+END_SRC
```

Commands are executed by positioning cursor on lines and pressing **F4** to send to vterm.

## Implementation Plan

### Week 1: Repository Creation
**Step 1**: Repository setup
- Create GitHub repository with structure
- Add MIT license and basic README

**Step 2**: Content migration
- Extract content from existing `readme.org`
- Create unified `librechat-aws-deployment.org`
- Convert commands to live-scripting format

**Step 3**: Configuration migration
- Move Terraform configs to `terraform/`
- Consolidate Docker configs to `configs/`
- Copy diagrams to `diagrams/`

### Week 2: Testing & Validation

## 🎯 **CURRENT MILESTONE** (2025-05-31)
**✅ Step 3 COMPLETED**: Configuration migration
- ✅ Terraform configs moved to `terraform/`
- ✅ Docker configs consolidated to `configs/`
- ✅ Working diagrams restored from original source
- ✅ DrawIO diagram rendering errors fixed
- ✅ Repository structure validated and committed

**🚀 NEXT**: Diagram Architecture Updates

---

**Step 3.5**: Diagram Architecture Updates *(CURRENT STEP)*
- **Objective**: Modify diagrams to reflect current deployment architecture using Claude Code
- Update `aws-architecture.drawio` with latest infrastructure components
- Update `docker-architecture.drawio` with current container architecture  
- Ensure diagrams accurately represent the librechat-aws-deployment.org workflow
- Add any missing components (Bedrock integration, RAG setup, SSL configuration)
- Validate diagram accuracy against actual deployment steps

**Step 4**: End-to-end testing
- Test complete workflow in fresh AWS environment
- Document troubleshooting experiences
- Validate all checkpoints

**Step 5**: Final polish
- Complete README with usage instructions
- Final validation and cleanup
- Publish repository

## Validated Features
The implementation includes these existing, validated components:

### Infrastructure
- Terraform automation for AWS EC2 deployment
- Security group configuration (ports 80, 443, 3080, 22)
- IAM roles for AWS Bedrock access
- GPU instance support (g5.xlarge)

### LibreChat Setup
- Docker containerization with networking
- SSL-enabled NGINX reverse proxy
- AWS Bedrock integration
- Multi-model support (Claude, DeepSeek, Nova)

### RAG Integration
- Ollama container for local embeddings
- Vector database for RAG functionality
- GPU acceleration for model inference
- LibreChat RAG configuration

## Success Criteria
1. **Executable workflow**: Complete org-mode file runs end-to-end in clean AWS environment
2. **Live-scripting demonstration**: Proper F4 execution throughout workflow
3. **Reproducible deployment**: Others can follow and achieve same results
4. **Working system**: Complete HTTPS LibreChat with AWS Bedrock and RAG

## Content Strategy
The org-mode file integrates:
- **Technical workflow** with executable commands
- **Personal narrative** explaining motivation and context
- **Real-time troubleshooting** captured during execution
- **Validation checkpoints** with technical and experiential observations
- **Reflection sections** on lessons learned

This approach demonstrates Andreas Wittmann's live-scripting methodology through a practical, real-world deployment scenario.
