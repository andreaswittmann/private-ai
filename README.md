# Private AI - LibreChat AWS Live-Scripting Repository

A complete demonstration of privacy-focused AI deployment with LibreChat and AWS Bedrock, showcasing self-hosted AI solutions with full data control.

## 🎯 Project Overview

This repository demonstrates a **privacy-focused AI approach** through a complete, self-hosted LibreChat deployment with AWS Bedrock integration. The primary goal is to show how to maintain full control over your AI interactions and data while leveraging powerful cloud-based models. The implementation uses Andreas Wittmann's live-scripting methodology as the demonstration technique, though the approach can be adapted to traditional copy-paste workflows.

## 🚀 Key Features

- **Privacy-Focused AI**: Complete self-hosted solution with AWS Bedrock models (Claude, Nova, DeepSeek)
- **Data Control**: All conversations and configurations remain under your control
- **Live-Scripting Demonstration**: Interactive deployment using F4 execution methodology (adaptable to copy-paste)
- **Foundation for Production**: SSL/HTTPS, Docker containerization, basic security - ready for production enhancement
- **Advanced Capabilities**: RAG functionality with Ollama, multi-model support
- **Infrastructure as Code**: Terraform automation for AWS EC2 deployment

## 📁 Repository Structure

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

## 🔧 Prerequisites

- AWS Account with Bedrock access enabled
- Terraform installed (v1.0+)
- AWS CLI configured
- SSH key pair for EC2 access
- Emacs with org-mode and vterm for live-scripting

## 📖 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/private-ai.git
   cd private-ai
   ```

2. **Open the live-scripting workflow**
   ```bash
   emacs librechat-aws-deployment.org
   ```

3. **Follow the interactive deployment**
   - **Emacs users**: Use F4 (`aw_send-line-to-vterm`) to execute commands line by line
   - **Alternative approach**: Copy and paste commands from the org-mode file to your terminal
   - Complete each checkpoint before proceeding
   - Document your experience in real-time

## 📖 Documentation Formats

The main workflow is available in multiple formats:

- **`librechat-aws-deployment.org`** - Interactive org-mode file with live-scripting capabilities (F4 execution)
- **`librechat-aws-deployment.html`** - Styled HTML version using ReadTheOrg theme for web viewing
- **Copy-paste friendly** - All commands can be executed in any terminal environment

### HTML Export

The project includes a customized ReadTheOrg theme (`aw-org-html-themes/`) for beautiful HTML documentation:

```bash
# Export org file to HTML (requires Emacs)
emacs --batch --eval "(progn (find-file \"librechat-aws-deployment.org\") (org-html-export-to-html))"
```

The HTML version provides the same content with professional styling, table of contents, and responsive design suitable for sharing and web viewing.

## 🎓 Implementation Approaches

### Live-Scripting Method (Primary Demonstration)
This project primarily demonstrates Andreas Wittmann's live-scripting approach:
- **Editor**: Emacs with org-mode and vterm side-by-side
- **Execution**: `aw_send-line-to-vterm` (F4 key) sends commands to terminal
- **Benefits**: Interactive, documented, reproducible workflow

### Copy-Paste Alternative
For those not using Emacs:
- Open `librechat-aws-deployment.org` in any text editor
- Copy command blocks and paste into your terminal
- Follow the same checkpoints and validation steps
- **Documentation**: Code blocks provide clear command sequences
- **Session**: Maintain consistent terminal session throughout workflow

## 🏗️ Architecture

The deployment creates a foundational privacy-focused AI system:

- **AWS EC2 Instance**: Automated provisioning with Terraform
- **LibreChat**: Containerized deployment with Docker Compose
- **AWS Bedrock Integration**: Multiple AI models (Claude, Nova, DeepSeek)
- **RAG Capabilities**: Ollama integration for document processing
- **Basic Security**: SSL/HTTPS, security groups, IAM roles

**Note**: This implementation provides a solid foundation for production use but requires additional considerations for enterprise deployment such as high availability, scaling strategies, backup procedures, and advanced monitoring.

## 📚 Workflow Structure

The `librechat-aws-deployment.org` file contains:

1. **Foundation & Prerequisites** - Environment setup and validation
2. **Infrastructure as Code** - Terraform deployment and EC2 provisioning
3. **Core LibreChat Deployment** - Docker setup and basic functionality
4. **Security & Production** - SSL certificates and security hardening
5. **Advanced Features** - RAG functionality and multi-model integration
6. **Troubleshooting & Maintenance** - Common issues and solutions
7. **Reflection & Lessons Learned** - Personal insights and discoveries

## ✅ Success Criteria

- **Privacy-focused AI system**: Complete self-hosted LibreChat with AWS Bedrock integration
- **Methodology demonstration**: Successful execution via live-scripting (or copy-paste alternative)
- **Reproducible deployment**: Others can follow and achieve same results
- **Functional system**: Working HTTPS LibreChat with multi-model support and RAG capabilities
- **Foundation for production**: Ready for enhancement with scaling, HA, and enterprise features

## 🤝 Contributing

This repository focuses on demonstrating **privacy-focused AI deployment** through live-scripting methodology. Contributions should:
- Maintain the educational and demonstrative nature
- Preserve the privacy-first approach
- Support both live-scripting and copy-paste workflows
- Consider this as a foundation rather than final production system

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Resources

- [Andreas Wittmann's Live-Scripting Methodology](https://example.com)
- [LibreChat Documentation](https://www.librechat.ai/)
- [AWS Bedrock](https://aws.amazon.com/bedrock/)

---

*This repository demonstrates **privacy-focused AI deployment** as its primary goal, using live-scripting methodology as an implementation technique. The result provides a solid foundation for production systems while maintaining complete control over your AI interactions and data.*
