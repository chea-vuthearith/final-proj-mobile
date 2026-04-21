import { Controller, Post, Body, Param, Inject } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Controller('chats')
export class ChatsController {
  constructor(@Inject(PrismaService) private prisma: PrismaService) {}

  @Post()
  async create(@Body() data: { classId: string; participants: { id: string; name: string }[] }) {
    const chat = await this.prisma.chat.create({
      data: { classId: data.classId },
    });

    for (const p of data.participants) {
      await this.prisma.chatParticipant.create({
        data: { chatId: chat.id, userId: p.id },
      });
    }

    return this.prisma.chat.findUnique({
      where: { id: chat.id },
      include: { participants: { include: { user: true } }, messages: true, class: true },
    });
  }

  @Post(':chatId/messages')
  async addMessage(@Param('chatId') chatId: string, @Body() data: { from: string; message: string }) {
    return this.prisma.chatMessage.create({
      data: { chatId, from: data.from, message: data.message },
    });
  }
}